## prepares nodes to join a kubernetes cluster
 - Expects that the debian base config playbook has already been run.
 - Adds docker and k8s repos
 - Installs containerd, kubectl kubeadm, kubectl. 
 - I want to learn k8s configuration the hard way from that point. 


 ## TODO / TOLEARN
 1. Set versions for kube packages.
 1. docker is deprecated for k8s, but the ACG course I want to take uses docker. After completing the outdated course and researching some more, modify `kube-all-setup.yml` to use containerd directly instead of docker as shown in this up-to-date pluralsight course:
    - https://app.pluralsight.com/course-player?clipId=a26cfcd6-7693-49b7-8afb-0340d4355b50
    - https://docs.ansible.com/archive/ansible/2.3/modprobe_module.html
    - [NEVERMIND ITS ALREADY DONE FOR ME](https://www.adminz.in/2022/01/kubernetes-with-containerd-using-ansible.html?m=1)
        - This guy is way ahead of me. Read through and take all the good bits! Also for my `base-config` stuff.
        