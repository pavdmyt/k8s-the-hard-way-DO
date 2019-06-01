clean:
	@rm *.json *.pem *.csr

gen-certs: clean
	@./gen_cert_authority.sh
	@./gen_admin_client_cert.sh
	@./gen_kubelet_client_certs.sh
	@./gen_controller_manager_client_cert.sh
	@./gen_kube_proxy_client_cert.sh
	@./gen_scheduler_client_cert.sh
	@./gen_api_server_cert.sh
	@./gen_service_account_cert.sh

gen-kubeconfigs:
	@./gen_kubelet_kubeconfigs.sh
	@./gen_kube_proxy_kubeconfig.sh
	@./gen_kube_controller_mngr_kubeconfig.sh
	@./gen_kube_scheduler_kubeconfig.sh
	@./gen_admin_kubeconfig.sh

distribute-certs:
	@./distribute_worker_certs.sh
	@./distribute_master_certs.sh

distribute-kubeconfigs:
	@./distribute_worker_kubeconfigs.sh
	@./distribute_master_kubeconfigs.sh
