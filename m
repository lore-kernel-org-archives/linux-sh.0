From: yoshii.takashi@renesas.com
Date: Thu, 10 Dec 2009 07:01:32 +0000
Subject: Re: [PATCH] sh: Add CONFIG_PARAM_* to set boot parameters.
Message-Id: <20091210160132.3ef4b2a9.yoshii.takashi@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20091130170254.65d2a0ab.yoshii.takashi@renesas.com>
In-Reply-To: <20091130170254.65d2a0ab.yoshii.takashi@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Thank you for your comment.

Here is the new version. I hope next version will be a patch.
 Add corresponding kernel version.
 Add some about binary format.
 Add parameter type "kernel to loader" / "loader to kernel".
 Mode_flag is considered as a part of ABI.
 Update status survey.
 ... and some others

> > 1. Initialize memory system.
...
> These days we inherit the BSC settings but the PFC settings are almost
> entirely blown away by the kernel through the pinmux code. ...
Oh, yes. I have moved PFC things to historical.

> ...
> Given that most of the BSC settings in the boot loaders are just lazily
> copied from one platform to another, doing it properly in the kernel is
> certainly a step up.

Basically, I think so, too. Though, we have to consider that
1. There are some registers defined as "should be initialized only once".
 Well, I dont' think it is a big problem because, in such case, I guess the
 loader itself is included in kernel. (but, then....)
2. People may want to have "hidden/proprietary" initialization routine.
 Perhaps, who want do spacial have to do specially.

> > Name: (Mode_flag?)
...
> Correct, this is the 32bit boot flag. It's provided as a hint to figure
...
Stuart> ...(more explanation. thank you)

Now, this seems to be good to be described as a part of ABI.
This must be the first "kernel to loader" information, which we might
want to have more (like page size info, PMB usage info, ....).

> > U-Boot:
Reading source code, is seems to clear parameters area, and add CMDLINE.
It seems that "Just clear params, and add CMDLINE" is the majority.
Perhaps, it should be improved when they(?) add initrd support.

> > kexec:
> >  (Please fill this)
> > 
> In the kexec case the page is zeroed and the command line is copied in.
> So, only the command line is valid.
Thank you.
But I found another....

1. It checks "HdrS" bzImage signature. 
  It is OK. I found lilo does, too. I added this to the document.

2. It scans the binary to find the entry address.
 This searches "word other than NOP" from the middle of the head.S back to
 the beginning. Then use two long values there as size and entry point.

What should I say? F- something?
/yoshii

Linux/SH boot protocol
----------------------
The status at v2.6.32.

== Binary format
vmlinux:
 This is an ELF executable file.
 Has .empty_zero_page section.
 Has entry point information.

zImage:
 This is a raw binary.
 Entry point is at the beginning of the binary.
 Has signature and other flags to fake bzImage at offset 0x200.

== Boot procedure

1. Initialize memory system.
 Do BSC and SDRAM setting if needed to access to main memory.
 ** Historical(...v2.6.30)
   Do PFC setting. That won't be done by kernel.

2. Load kernel and initrd (optional)
 vmlinux is ELF file. Load it according to ELF information.
 zImage is position independent binary. Can be placed to anywhere.

 If you are using initrd. Put its image on memory.
 It can be placed to anywhere as far as it is...
 . Higher than CONFIG_MEMORY_START of kernel configuration parameter.
 . Not overlapping to kernel itself.
  Be careful especially using zImage because no area information is provided.
  Check the configuration file of the kernel and corresponding vmlinux.

3. Set parameters
 Fill parameter fields.

 vmlinux is ELF and has ".empty_zero_page" section. Use it to know
 where the parameter area is.
 zImage doesn't provide the way to know the location.
 Check your kernel configuration file to know where it is.

 vmlinux has some values in empty_zero_page, but they should not be
 used as default values. They are not reflecting kernel configuration.
 zImage provides no empty_zero_page, clear the location first.

4. Jump to the entry
 vmlinux has entry point information provided according to ELF spec.
 zImage's entry point is the top of the binary.
 Registers can hold any value, except SR.MD which should be 1.

== Parameters
All of parameters are passed through empty_zero_page.

Name: MOUNT_ROOT_RDONLY
Address/size: empty_zero_page+0/long
Type: loader to kernel information

 0: mount root rw
 *: mount root ro
 Using this field is discouraged.
 Use "ro" or "rw" command line option instead.

Name: RAMDISK_FLAGS
Address/size: empty_zero_page+4/long
Type: loader to kernel information

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
   Overridden by "ramdisk_start=" command line option which
   is not described in kernel-parameters.txt

Name: ORIG_ROOT_DEV
Address/size: empty_zero_page+8/long
Type: loader to kernel information

 Initial value of ROOT_DEV.
 This is the source device of ramdisk when do_load=1, that is the
 difference from "root=" option.
 Ignored when initrd is used.

Name: LOADER_TYPE
Address/size: empty_zero_page+0xc/long
Type: loader to kernel information

 Guessed from x86 spec, this field holds the ID and Version of boot loader.
 If this is 0, INITRD_START and INITRD_SIZE fields are not used.
 
Name: INITRD_START
Address/size: empty_zero_page+0x10/long
Type: loader to kernel information

 Initrd address offset from  kernel CONFIG_MEMORY_START.
 Setting this field 0 disables initrd.

Name: INITRD_SIZE
Address/size: empty_zero_page+0x14/long
Type: loader to kernel information

 Size of initrd image.
 Be aware setting this field 0 does NOT disable initrd.

Name: (Mode_flag)
Address/size: empty_zero_page+0x18/long
Type: kernel to loader information

 In vmlinux, this field carries the value indicate 29bit/32bit.

Name: CMDLINE
Address/size: empty_zero_page+0x100/char[256]
Type: loader to kernel information

 kernel may read this as a command line depending on its configuration.
 Boot loader should put '\0' if no options.

--
Lines below are not a part of ABI specification.

== Supporting states survey

vmlinux:
 Values in arch/sh/kernel/head_32.S
 This provide all flags, but command-line.
 Values except Mode_flag are bogus but harmless.

 MOUNT_ROOT_RDONLY: 1
 RAMDISK_FLAGS: 0
 ORIG_ROOT_DEV: 200
 LOADER_TYPE: 1
 INITRD_START: 0
 INITRD_SIZE: 0
 Mode_flag: 0x53453f20 or 0x53453f1d
 CMDLINE: filled by 0

ipl+g/ethboot
 ipl+g built-in network boot loader.

 empty_zero_page is cleard to 0.
 CMDLINE: string from DHCP

sh-lilo:
 Old one.
 Installer command(lilo) checks the zImage signature and version.

 empty_zero_page is cleared to 0.
 CMDLINE: built-in constant string.

sh-lilo-sel:
 New one found in Landisk and some others.
 This fills all parameters.
 This treat Mode_flag as reserved.
 This one uses LOADER_TYPE as ID. (comment in source says "LILO = 1").
 Installer command(lilo) checks the zImage signature and version.

 MOUNT_ROOT_RDONLY: 1
 RAMDISK_FLAGS: 0
 ORIG_ROOT_DEV: 201
 LOADER_TYPE: 1
 INITRD_START: 
 INITRD_SIZE: 
 Mode_flag: 0
 CMDLINE: string from command-line sector of boot device.

RedBoot:
 On RedBoot, all parameters are user configurable.
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
 Qemu built-in linux loader.

 CMDLINE: string from qemu command-line option.
 Others are left untouched but it means 0 on this system.

U-Boot:
 empty_zero_page is cleard to 0.
 CMDLINE: string from u-boot environment variable.

kexec:
 empty_zero_page is cleared to 0.
 CMDLINE: string from kexec command-line option.
 Checks zImage signature.
 Finds entry address by scanning the binary.

--
