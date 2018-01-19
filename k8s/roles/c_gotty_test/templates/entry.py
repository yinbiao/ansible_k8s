#!/bin/env python
# -*- coding: utf-8 -*-


from kubernetes import client, config
import sys
import os


class K8sClient(object):

    def __init__(self):
        config.load_kube_config()
        self.v1 = client.CoreV1Api()

    def get_pod_status(self, tag):
        '''获取pod的状态
        return 0: 正常 1：正在启动 2：启动出错
        '''
        objs = self.v1.list_pod_for_all_namespaces(label_selector=tag)
        if not objs.items: return 2, u'容器不存在，分支名称不合法，只支持[a-z]([-a-z0-9]*[a-z0-9])?'
        for obj in objs.items:

            for item in obj.status.conditions:
                if item.status == 'False':
                    if item.reason != 'ContainersNotReady':
                        return 2, '{0} {1}'.format(item.message, item.reason)

            for item in obj.status.container_statuses:
                if item.ready:
                    return 0, obj.metadata.name
                else:
                    if item.state.waiting:
                        if item.state.waiting.message:
                            return 2, '{0} {1}'.format(item.state.waiting.message,
                                                       item.state.waiting.reason)
                        else:
                            return 1, ''
                    else:
                        if item.state.terminated:
                            return 2, 'exit_code: {0} {1} {2}'.format(
                                item.state.terminated.exit_code,
                                item.state.terminated.message,
                                item.state.terminated.reason)
                        else:
                            return 2, u'其他错误，也许CrashLoopBackOff'


if __name__ == '__main__':
    argv = sys.argv
    if len(argv) != 2:
        print u"Error: 参数不正确"
    else:
        tagname = 'app={0}'.format(argv[1])
        try:
            kc = K8sClient()
            status, msg = kc.get_pod_status(tagname)
            if status == 0:
                os.system('kubectl exec -it {0} /bin/bash'.format(msg))
            else:   
                print u"Error: {1}".format(status, msg)
        except Exception as esc:
            print u"Error: 运行出错 {0}".format(esc)


            