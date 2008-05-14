From: "Roni Feldman" <ronifeldman@gmail.com>
Date: Wed, 14 May 2008 19:32:54 +0000
Subject: Re: SH7751R - STRANGE initramfs/rootfs behavior
Message-Id: <7b5883fc0805141232y26b3efcbl509245ed96b28b3c@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <9e0cf0bf0804070616y72f1bf4er6dcbb23188937543@mail.gmail.com>
In-Reply-To: <9e0cf0bf0804070616y72f1bf4er6dcbb23188937543@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

It seems that the bug in memcpy caused the specific crc error in my
setup. Replacing
memcpy-sh4.S with the more generic sh memcpy.S seemed to fix the issue
in inflate()'s code.
Later on I will apply Hideo's patch to see if the problem returns.
Looks like one bug caused another to be found, which is always good news.

On Tue, May 13, 2008 at 10:38 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Mon, Apr 07, 2008 at 04:16:01PM +0300, Alon Bar-Lev wrote:
>> Hello,
>>
>> I am trying to boot 2.6.24 kernel on SH7751R big endian (sh4eb) using
>> embedded initramfs, anyone have this configuration working?
>>
>> I use zImage converted to srec using objcopy, load the srec into
>> memory and jump to the load address of the kernel.
>>
>> The kernel boots, but when trying to decompress the initramfs image it
>>  fails with "crc error",  resulting from lib/inflate.c::gunzip:1250.
>>
>> Has anyone got this error? The initramfs image is correct. I also
>> dumped the memory of __initramfs_start->__initramfs_start and verified
>> that it matches the initramfs image on usr/initramfs_data.cpio.gz.
>>
>> I then noticed that the kernel code at
>> init/initramfs::unpack_to_rootfs:459 supports handling  uncompressed
>> archives. So I compiled a kernel with uncompressed archived.
>>
>> I also hooked the init/initramfs::do_name:585 functions, and see that
>> "/init' is passed to sys_open, and sys_open returns with -EOENT (-2).
>>
>>  How can it be? shouldn't rootfs always be available?
>>
>>  The same attempt on i586, mipsel is working as expected.
>>
>>  Any ideas?
>>  1. Why decompression working for kernel and not for initramfs (crc error).
>>  2. Why files cannot be created on rootfs?
>>
> Ok, this was fun to debug. The problem was related to initrd handling,
> not the initramfs bits itself. init/initramfs.c:populate_rootfs() itself
> has no problems on the __initramfs_start -> __initramfs_end unpack, but
> after this, initrd_start is tested unconditionally and triggers an
> additional call in to unpack_to_rootfs().
>
> Inserting a dump_mem() in unpack_to_rootfs() after the inbuf pointer has
> been assigned (prior to the gunzip()), you can see that there are
> multiple invocations, and while the first is correct, the second one is
> complete garbage -- which is ultimately what causes it to bail out with a
> vague crc or header magic mismatch error.
>
> The reason for this is that the default values in .empty_zero_page
> contain an initrd start/size and valid loader type, and while some boot
> loader and kernel configurations fix this up correctly, others do not,
> which cause the defaults to be used instead.
>
> This should fix it up, and also provide some more debugging information
> so it's more obvious how the boot params in .empty_zero_page look on
> entry.
>
> ---
>
> diff --git a/arch/sh/kernel/head_32.S b/arch/sh/kernel/head_32.S
> index d67d7ed..ae0a382 100644
> --- a/arch/sh/kernel/head_32.S
> +++ b/arch/sh/kernel/head_32.S
> @@ -30,8 +30,8 @@ ENTRY(empty_zero_page)
>        .long   0               /* RAMDISK_FLAGS */
>        .long   0x0200          /* ORIG_ROOT_DEV */
>        .long   1               /* LOADER_TYPE */
> -       .long   0x00360000      /* INITRD_START */
> -       .long   0x000a0000      /* INITRD_SIZE */
> +       .long   0x00000000      /* INITRD_START */
> +       .long   0x00000000      /* INITRD_SIZE */
>  #ifdef CONFIG_32BIT
>        .long   0x53453f00 + 32 /* "SE?" = 32 bit */
>  #else
> diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
> index 516bde9..bca2bbc 100644
> --- a/arch/sh/kernel/setup.c
> +++ b/arch/sh/kernel/setup.c
> @@ -292,6 +292,17 @@ void __init setup_arch(char **cmdline_p)
>
>        ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
>
> +       printk(KERN_NOTICE "Boot params:\n"
> +                          "... MOUNT_ROOT_RDONLY - %08lx\n"
> +                          "... RAMDISK_FLAGS     - %08lx\n"
> +                          "... ORIG_ROOT_DEV     - %08lx\n"
> +                          "... LOADER_TYPE       - %08lx\n"
> +                          "... INITRD_START      - %08lx\n"
> +                          "... INITRD_SIZE       - %08lx\n",
> +                          MOUNT_ROOT_RDONLY, RAMDISK_FLAGS,
> +                          ORIG_ROOT_DEV, LOADER_TYPE,
> +                          INITRD_START, INITRD_SIZE);
> +
>  #ifdef CONFIG_BLK_DEV_RAM
>        rd_image_start = RAMDISK_FLAGS & RAMDISK_IMAGE_START_MASK;
>        rd_prompt = ((RAMDISK_FLAGS & RAMDISK_PROMPT_FLAG) != 0);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
