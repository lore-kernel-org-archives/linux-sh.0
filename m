From: yoshii.takashi@gmail.com
Date: Thu, 10 Dec 2009 05:00:25 +0000
Subject: Re: [PATCH] sh: Add CONFIG_PARAM_* to set boot parameters.
Message-Id: <20091210140025.9f989f97.yoshii.takashi@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20091130170254.65d2a0ab.yoshii.takashi@renesas.com>
In-Reply-To: <20091130170254.65d2a0ab.yoshii.takashi@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

> >  zImage doesn't provide the way to know the location.
> >  Check your kernel configuration file to know where it is.
> 
> This is the bit which is nasty. Because we don't use the parameters which
> are part of the zImage header (head.S) which are still set up for x86,
> the boot loader has to know where empty zero page will end up.
Right.
Generally, SH's zImage lacks of "kernel to loader" information.
Partly because that is a raw binary, and partly because we discard empty_zero_page
during conversion. # Even ABI itself and vmlinux do little, too, But ELF helps.

1. Adding some information to zImage
If we are using zImage in the future(perhaps YES), I think we should change it
(but by compatible manner) to carry the information same as vmlinux does.
This can include not only ELF info but also the default boot parameters.

I think we need the followings, at least
- empty_zero_page address (for the location to parameters be written).
- Size of zImage (same as above. Useful when copy the binary)
  # I know some people get them by poking the binary.
- Default values of parameters which are same as vmlinux carries.
and possibly
- Address of zImage (we should reserve this area because zImage copy itself there)
- Size of vmlinux (to know where to place initrd and so on)
- Entry point of zImage (not needed if it is always offset 0)
- ABI version (this might be not only for zImage but also for vmlinux)

Maybe, when I added fake bzImage support, I should have added part 1 header
which is good place to put the default values of parameters. (like x86 does)
But, what I added was only part 2 of x86 headers(After "Hdrs" signature).

Location can be other than offset 497 of x86, because
- SH have no boot sector nor "rdev" interface to handle the defaults.
- Our parameters are at offset 0 anyway (which is not applicable to zImage).
But, of course, the location should be defined in ABI.

(proposal)
startup+0x220/long	Address of empty_zero_page
startup+0x224/long	Size of zImage
startup+0x228/long	Offset(from start) of default value block

2. Handling of default command line.
I think it is better if we could provide default command line to boot loaders.
And, I wonder if extend/override selection can be done by boot loader.
This is new even for vmlinux.

(proposal)
Name: command line offset
Address/size: empty_zero_page+0x1c/long
Type: kernel to boot loader information.

 This is the location of the default command line provided kernel.
  vmlinux: offset from empty_zero_page
  zImage: offset from the start of the binary
 0 means no command line information is provided.

Though it might be not a part of ABI, 0x100 might be good for both vmlinux
and zImage. I mean, CMDLINE at 0x100 in vmlinux can carry the default value.

Attached patch is experimental implementation of 1, 2 and CONFIG_PARAM,
only for description. I think I can make me understood better by C than English.

> >  zImage's entry point is the top of the binary.
> 
> Are you sure, I thought was was the start?
Ah... What I mean was "at the beginning of the binary". Was it a bottom?
Is it right to say "zImage's entry point is at the start of the binary" ?

> >> Name: (Mode_flag?)
...
> in expectation that SE would already be on.
Hmm, I see "x?ES" in the binary. Well, perhaps I should write about endian.

> The 'contract' between the boot loader and the kernel in this case also
> has to include the state of the PMB. We did write something about this,
> I'll see if I can dig it up...
Ah, yes. We also know what is the "fixed" PMB like.

/yoshii

diff --git a/arch/sh/boot/compressed/head_32.S b/arch/sh/boot/compressed/head_32.S
index 02a3093..0a96edb 100644
--- a/arch/sh/boot/compressed/head_32.S
+++ b/arch/sh/boot/compressed/head_32.S
@@ -99,6 +99,12 @@ decompress_kernel_addr:
 kernel_start_addr:
 	.long	_text+PAGE_SIZE
 
+#if defined(CONFIG_CMDLINE)
+	.skip	startup + 0x100 - .
+cmdline:
+	.asciz	CONFIG_CMDLINE	! default command line
+#endif
+
 	.align	9
 fake_headers_as_bzImage:
 	.word	0
@@ -117,3 +123,48 @@ fake_headers_as_bzImage:
 	.long	0x100000	! 0x100000 = default for big kernel
 	.long	0		! address of loaded ramdisk image
 	.long	0		# its size in bytes
+
+	.skip	startup + 0x220 - .
+
+	! address of empty_zero_page
+#ifdef CONFIG_PMB_FIXED
+	.long	CONFIG_PAGE_OFFSET + (CONFIG_MEMORY_START & 0x1fffffff) \
+		+ CONFIG_ZERO_PAGE_OFFSET
+#elif defined(CONFIG_32BIT)
+	.long	CONFIG_PAGE_OFFSET + CONFIG_ZERO_PAGE_OFFSET
+#else
+	.long	CONFIG_PAGE_OFFSET + CONFIG_MEMORY_START \
+		+ CONFIG_ZERO_PAGE_OFFSET
+#endif
+	.long	_edata - startup	! size of zImage
+	.long	default_values - startup
+
+	! default values of boot parameters and flags
+	.align	2
+default_values:
+#ifdef CONFIG_PARAM_BOOL
+	.long	CONFIG_PARAM_MOUNT_ROOT_RDONLY
+	.long	CONFIG_PARAM_RAMDISK_FLAGS
+	.long	CONFIG_PARAM_ORIG_ROOT_DEV
+	.long	CONFIG_PARAM_LOADER_TYPE
+	.long	CONFIG_PARAM_INITRD_START
+	.long	CONFIG_PARAM_INITRD_SIZE
+#else
+	.long	1		/* MOUNT_ROOT_RDONLY */
+	.long	0		/* RAMDISK_FLAGS */
+	.long	0x0200		/* ORIG_ROOT_DEV */
+	.long	1		/* LOADER_TYPE */
+	.long	0x00000000	/* INITRD_START */
+	.long	0x00000000	/* INITRD_SIZE */
+#endif
+	! Mode flag
+#ifdef CONFIG_32BIT
+	.long	0x53453f00 + 32 /* "SE?" = 32 bit */
+#else
+	.long	0x53453f00 + 29 /* "SE?" = 29 bit */
+#endif
+#if defined(CONFIG_CMDLINE)
+	.long	cmdline - startup	! offset of the default command line
+#else
+	.long	0			! no default provided
+#endif
diff --git a/arch/sh/kernel/head_32.S b/arch/sh/kernel/head_32.S
index a78be74..58325fe 100644
--- a/arch/sh/kernel/head_32.S
+++ b/arch/sh/kernel/head_32.S
@@ -27,17 +27,36 @@
 
 	.section	.empty_zero_page, "aw"
 ENTRY(empty_zero_page)
+#ifdef CONFIG_PARAM_BOOL
+	.long	CONFIG_PARAM_MOUNT_ROOT_RDONLY
+	.long	CONFIG_PARAM_RAMDISK_FLAGS
+	.long	CONFIG_PARAM_ORIG_ROOT_DEV
+	.long	CONFIG_PARAM_LOADER_TYPE
+	.long	CONFIG_PARAM_INITRD_START
+	.long	CONFIG_PARAM_INITRD_SIZE
+#else
 	.long	1		/* MOUNT_ROOT_RDONLY */
 	.long	0		/* RAMDISK_FLAGS */
 	.long	0x0200		/* ORIG_ROOT_DEV */
 	.long	1		/* LOADER_TYPE */
 	.long	0x00000000	/* INITRD_START */
 	.long	0x00000000	/* INITRD_SIZE */
+#endif
 #ifdef CONFIG_32BIT
 	.long	0x53453f00 + 32	/* "SE?" = 32 bit */
 #else
 	.long	0x53453f00 + 29	/* "SE?" = 29 bit */
 #endif
+#if defined(CONFIG_CMDLINE)
+	.long	0x100		/* offset of the default command line */
+#else
+	.long	0
+#endif
+#if defined(CONFIG_CMDLINE)
+	.skip	empty_zero_page + 0x100 - .
+cmdline:
+	.asciz	CONFIG_CMDLINE	! default command line
+#endif
 1:
 	.skip	PAGE_SIZE - empty_zero_page - 1b
 
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 88cdeb9..97b2668 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -799,6 +799,41 @@ config CMDLINE
 	depends on CMDLINE_OVERWRITE || CMDLINE_EXTEND
 	default "console=ttySC1,115200"
 
+config PARAM_BOOL
+	bool "Default kernel params"
+	help
+	  Setting this option allows the boot parameters to be set.
+
+config PARAM_MOUNT_ROOT_RDONLY
+	int "MOUNT_ROOT_RDONLY"
+	depends on PARAM_BOOL
+	default 1
+
+config PARAM_RAMDISK_FLAGS
+	hex "RAMDISK_FLAGS"
+	depends on PARAM_BOOL
+	default 0
+
+config PARAM_ORIG_ROOT_DEV
+	hex "ORIG_ROOT_DEV"
+	depends on PARAM_BOOL
+	default 0x200
+
+config PARAM_LOADER_TYPE
+	hex "LOADER_TYPE"
+	depends on PARAM_BOOL
+	default 1
+
+config PARAM_INITRD_START
+	hex "INITRD_START"
+	depends on PARAM_BOOL
+	default 0
+
+config PARAM_INITRD_SIZE
+	hex "INITRD_SIZE"
+	depends on PARAM_BOOL
+	default 0
+
 endmenu
 
 menu "Bus options"
