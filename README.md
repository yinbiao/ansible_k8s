# ansible_k8s


#### 在vars/pro/main.yml中定义了两个变量，定义了需要上传包的两个目录
	
	KUBENETES_INSTALL_DIR: /Users/lonay/kubernetes/server/kubernetes/server/bin
	
	FLANNEL_INSTALL_DIR: /Users/lonay/Documents/mogo/storehouse/flannel-v0.9.1-linux-amd64
	

#### 部署

	以pro开头的yml文件都是部署响应模块的
	
	base_nodeinit.yml用于宿主机初始化脚本
	
	base_certupload.yml 用于将在主节点上生产的ca文件上传到需要用到的服务器上