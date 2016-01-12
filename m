From: Rob Landley <rob@landley.net>
Date: Tue, 12 Jan 2016 07:19:56 +0000
Subject: Re: Bootable sh4 qemu images.
Message-Id: <5694A91B.5080303@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <568FFC28.2010409@landley.net>
In-Reply-To: <568FFC28.2010409@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 01/11/2016 02:42 PM, Rob Landley wrote:
> On 01/11/2016 12:02 PM, Peter Zijlstra wrote:
>> Ah, so you've not yet found if I broken SH in 4.3 with:
>>
>> b31fdac2a921 ("sched, sh: Fold finish_arch_switch() into switch_to()")
>>
>> :-)
> 
> It's working fine with 4.3, native compiling static binaries under musl
> and everything:
...
> I might cut a release with _just_ the new kernel version to catch up...

And I did so, same as last time except newer kernel:

  http://landley.net/aboriginal/bin/system-image-sh4.tar.gz
  http://landley.net/aboriginal/bin/cross-comiler-sh4.tar.gz

Tested with qemu-system-sh4 2.5.0, ./dev-environment.sh booted to shell
prompt and built "hello world". (Static linked, anyway. Dynamic still
has a musl hiccup somewhere.)

Of course now 4.4 is out so I'm still a release behind, but mini.config
is there as is the cross compiler, so easy enough to make your own linux
replacement image (it's just vmlinux renamed, qemu has an elf loader,
the initramfs is external to make swapping it out easier, that's why
run-emulator.sh is feeding -initrd rootfs.cpio.gz to qemu instead of
having it linked in at build time).

Rob
