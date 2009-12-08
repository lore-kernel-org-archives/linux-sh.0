From: yoshii.takashi@renesas.com
Date: Tue, 08 Dec 2009 05:01:26 +0000
Subject: Re: [PATCH] sh: Add CONFIG_PARAM_* to set boot parameters.
Message-Id: <20091208140126.d63968b9.yoshii.takashi@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20091130170254.65d2a0ab.yoshii.takashi@renesas.com>
In-Reply-To: <20091130170254.65d2a0ab.yoshii.takashi@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul, thank you for your comments.

> But this breaks the entire boot ABI, and probably only for the reason ...
Well, it is not clear because the ABI is uncertain. (I mean, I think so:)
If you are saying ABI is important, I agree with you, and I will postpone the
patch. And we should refrain from changing ABI related thing until the ABI
become clear and fixed.

Here is the boot ABI guessed from current implementation and my bad memory.
Please give your comments. > All the developers.
After fixed, I'd like to have this as Documentation/sh/boot.txt.

Cheers,
/yoshii

Linux/SH boot protocol
----------------------

== Boot procedure

1. Initialize memory system.
 Do BSC and SDRAM and PFC setting if needed to enable to access to main
 memory and external peripherals. That won't be done by kernel.

2. Load kernel and initrd (optional)
 vmlinux is ELF file. Load it according to ELF information.
 zImage is position independent binary. Can be placed to anywhere.

 If you are using initrd. Put its image on memory.
 It can be placed to anywhere as far as it is...
 . higher than CONFIG_MEMORY_START of kernel configuration parameter.
 . not overlapping to kernel itself.
  Be careful especially using zImage because no area information is provided.
  Check the configuration file of the kernel you are loading.

3. Set parameters
 Fill parameter fields.

 vmlinux is ELF and has ".empty_zero_page" section. Use it to know
 where the parameter area is.
 zImage doesn't provide the way to know the location.
 Check your kernel configuration file to know where it is.

 vmlinux has some values in empty_zero_page, but they should not be
 used as default values. They are not reflecting kernel configuration.
 zImage provides no empty_zero_page, clear the location first.

 Valid length of CMDLINE depends on kernel configuration, but no way
 to know from the kernel file. Check your kernel configuration file.

4. Jump to the entry
 vmlinux has entry point information provided according to ELF spec.
 zImage's entry point is the top of the binary.
 Registers can hold any value, except SR.MD which should be 1.

== Parameters
All of parameters are passed through empty_zero_page.

Name: MOUNT_ROOT_RDONLY
Address/size: empty_zero_page+0/long

 0: mount root rw
 *: mount root ro
 Using this field is discouraged.
 Use "ro" or "rw" command line option instead.

Name: RAMDISK_FLAGS
Address/size: empty_zero_page+4/long

  Bit.15: rd_prompt
   0: non-interactive
   1: Request to prompt to change Floppy Disk before read initial data.
   Overridden by "prompt_ramdisk=" command line option.

  Bit.14: rd_doload 
   0: do not load ramdisk
   1: do load /dev/ram0
   Overridden by "load_ramdisk=" command line option.

  Bit[10..0]: rd_image_start
   Start offset of ramdisk image. Unit is BLOCK(24byte).
   Overridden by "load_ramdiskart=" command line option.

Name: ORIG_ROOT_DEV
Address/size: empty_zero_page+8/long

 Initial value of ROOT_DEV.
 This is the source device of ramdisk when do_load=1, that is the
 difference from "root=" option.
 Ignored when initrd is used.

Name: LOADER_TYPE
Address/size: empty_zero_page+0xc/long

 Guessed from x86 spec, this field holds the ID and Version of boot loader.
 If this is 0, INITRD_START and INITRD_SIZE fields are not used.
 
Name: INITRD_START
Address/size: empty_zero_page+0x10/long

 Initrd address offset from  kernel CONFIG_MEMORY_START.
 Setting this field 0 disables initrd.

Name: INITRD_SIZE
Address/size: empty_zero_page+0x14/long

 Size of initrd image.
 Be aware setting this field 0 does NOT disable initrd.

Name: (Mode_flag?)
Address/size: empty_zero_page+0x18/long

 This is not a part of boot ABI.
 In vmlinux, this field carries the value indicate 29bit/32bit.

Name: CMDLINE
Address/size: empty_zero_page+0x100/char[512]

 kernel may read this as a command line.
 Acceptable length varies from 0 to 512, depends on kernel configuration.
 Boot loader should put '\0' if no options.

--
Lines below are not a part of ABI specification.

== Supporting states survey

vmlinux:
 Values in arch/sh/kernel/head_32.S
 This provede all flags, but commandline.
 Values except Mode_flag are bogus but harmless.

 MOUNT_ROOT_RDONLY: 1
 RAMDISK_FLAGS: 0
 ORIG_ROOT_DEV: 200
 LOADER_TYPE: 1
 INITRD_START: 0
 INITRD_SIZE: 0
 Mode_flag: 0x53453f20 or 0x53453f1d
 CMDLINE: left untouched

ipl+g/ethboot
 ipl+g built-in network boot loader.

 empty_zero_page is cleard to 0.
 CMDLINE: string from DHCP

sh-lilo:
 Old one.

 empty_zero_page is cleard to 0.
 CMDLINE: built-in constant string.

sh-lilo-sel:
 New one found in Landisk and some others.
 This fills all parameters.
 This treat Mode_flag as reserved.
 This one uses LOADER_TYPE as ID. (comment in source says "LILO = 1").

 MOUNT_ROOT_RDONLY: 1
 RAMDISK_FLAGS: 0
 ORIG_ROOT_DEV: 201
 LOADER_TYPE: 1
 INITRD_START: 
 INITRD_SIZE: 
 Mode_flag: 0
 CMDLINE: string from command-line sector of boot device.

RedBoot:
 On RedBoot, all parameters are user parameter.
 This fills all parameters but Mode_flag.

 MOUNT_ROOT_RDONLY: any
 RAMDISK_FLAGS: any
 ORIG_ROOT_DEV: any
 LOADER_TYPE: any
 INITRD_START: any
 INITRD_SIZE: any
 Mode_flag: left untouched
 CMDLINE: any

qemu:
 Qemu builtin linux loader.
 On this system, untouched area is filled by 0.

 Parameters area is left untouched.
 CMDLINE: string from qemu command-line option.

U-Boot:
 (Please fill this)

kexec:
 (Please fill this)

--
