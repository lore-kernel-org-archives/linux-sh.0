From: Rob Landley <rob@landley.net>
Date: Wed, 22 Jun 2016 19:06:45 +0000
Subject: [PATCH] Make CONFIG_DEVTMPFS_MOUNT apply to initramfs/initmpfs.
Message-Id: <576AE1C5.5090909@landley.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, gregkh@linuxfoundation.org, pavel@ucw.cz, akpm@linux-foundation.org, tglx@linutronix.de, mgorman@suse.de, mingo@kernel.org, keescook@chromium.org, paulmck@linux.vnet.ibm.com

From: Rob Landley <rob@landley.net>

Make CONFIG_DEVTMPFS_MOUNT apply to initramfs/initmpfs.

Update help text, slightly improve error reporting, move /dev/console open
down after devtmpfs mount, don't check IS_ENABLED(CONFIG_TMPFS) before
mounting devtmpfs (it's always there, even if just a ramfs alias), and
report whether we think we're using tmpfs or ramfs for rootfs.

Signed-off-by: Rob Landley <rob@landley.net>
---

 drivers/base/Kconfig    |   10 ++++++----
 drivers/base/devtmpfs.c |    3 ++-
 init/do_mounts.c        |    7 +++----
 init/main.c             |   17 ++++++++++-------
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 98504ec..3fb07c1 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -45,16 +45,18 @@ config DEVTMPFS
 	  file system will be used instead.
 
 config DEVTMPFS_MOUNT
-	bool "Automount devtmpfs at /dev, after the kernel mounted the rootfs"
+	bool "Automount devtmpfs at /dev"
 	depends on DEVTMPFS
 	help
 	  This will instruct the kernel to automatically mount the
 	  devtmpfs filesystem at /dev, directly after the kernel has
 	  mounted the root filesystem. The behavior can be overridden
 	  with the commandline parameter: devtmpfs.mount=0|1.
-	  This option does not affect initramfs based booting, here
-	  the devtmpfs filesystem always needs to be mounted manually
-	  after the rootfs is mounted.
+	  
+	  In an initramfs based system, this can create the /dev directory
+	  as well. Other root filesystems require a /dev directory to exist
+	  to act as a mount point.
+	  
 	  With this option enabled, it allows to bring up a system in
 	  rescue mode with init=/bin/sh, even when the /dev directory
 	  on the rootfs is completely empty.
diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 44a74cf..eaf8532 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -356,7 +356,8 @@ int devtmpfs_mount(const char *mntdir)
 
 	err = sys_mount("devtmpfs", (char *)mntdir, "devtmpfs", MS_SILENT, NULL);
 	if (err)
-		printk(KERN_INFO "devtmpfs: error mounting %i\n", err);
+		printk(KERN_ERR "devtmpfs: error %i mounting on %s\n",
+			err, mntdir);
 	else
 		printk(KERN_INFO "devtmpfs: mounted\n");
 	return err;
diff --git a/init/do_mounts.c b/init/do_mounts.c
index dea5de9..6daf63e 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -599,7 +599,6 @@ void __init prepare_namespace(void)
 
 	mount_root();
 out:
-	devtmpfs_mount("dev");
 	sys_mount(".", "/", NULL, MS_MOVE, NULL);
 	sys_chroot(".");
 }
@@ -614,8 +613,9 @@ static struct dentry *rootfs_mount(struct file_system_type *fs_type,
 	if (test_and_set_bit(0, &once))
 		return ERR_PTR(-ENODEV);
 
-	if (IS_ENABLED(CONFIG_TMPFS) && is_tmpfs)
+	if (is_tmpfs)
 		fill = shmem_fill_super;
+	printk(KERN_INFO "rootfs is %s\n", is_tmpfs ? "tmpfs" : "ramfs");
 
 	return mount_nodev(fs_type, flags, data, fill);
 }
@@ -637,9 +637,8 @@ int __init init_rootfs(void)
 		(!root_fs_names || strstr(root_fs_names, "tmpfs"))) {
 		err = shmem_init();
 		is_tmpfs = true;
-	} else {
+	} else
 		err = init_ramfs_fs();
-	}
 
 	if (err)
 		unregister_filesystem(&rootfs_fs_type);
diff --git a/init/main.c b/init/main.c
index b3c6e36..e6bf551 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1007,12 +1007,6 @@ static noinline void __init kernel_init_freeable(void)
 
 	do_basic_setup();
 
-	/* Open the /dev/console on the rootfs, this should never fail */
-	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
-		pr_err("Warning: unable to open an initial console.\n");
-
-	(void) sys_dup(0);
-	(void) sys_dup(0);
 	/*
 	 * check if there is an early userspace init.  If yes, let it do all
 	 * the work
@@ -1024,7 +1018,16 @@ static noinline void __init kernel_init_freeable(void)
 	if (sys_access((const char __user *) ramdisk_execute_command, 0) != 0) {
 		ramdisk_execute_command = NULL;
 		prepare_namespace();
-	}
+	} else if (config_enabled(CONFIG_DEVTMPFS_MOUNT))
+		 sys_mkdir("/dev", 0755);
+	devtmpfs_mount("dev");
+
+	/* Open the /dev/console on the rootfs, this should never fail */
+	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
+		pr_err("Warning: unable to open an initial console.\n");
+
+	(void) sys_dup(0);
+	(void) sys_dup(0);
 
 	/*
 	 * Ok, we have completed the initial bootup, and
