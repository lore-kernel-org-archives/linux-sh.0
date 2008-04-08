From: "Alon Bar-Lev" <alon.barlev@gmail.com>
Date: Tue, 08 Apr 2008 05:11:18 +0000
Subject: Re: SH7751R - STRANGE initramfs/rootfs behavior
Message-Id: <9e0cf0bf0804072211j475bdef6hd805095100d2c972@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <9e0cf0bf0804070616y72f1bf4er6dcbb23188937543@mail.gmail.com>
In-Reply-To: <9e0cf0bf0804070616y72f1bf4er6dcbb23188937543@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 4/8/08, David McCullough <David_Mccullough@securecomputing.com> wrote:
>  and the initramfs is created with:
>
>         cd rootfsdir; find . | cpio --quiet -o -H newc > /tmp/XX.ramfs.cpio
>
>  followed of course by a:
>
>         make vmlinux
>
>  or whatever you need, maybe there is something in there that helps,

Thank you David!
The initramfs is OK.
I use the same process in mipsel and i368.
When I hack the kernel and make it link uncompressed initramfs, I can
see the cpio extraction. But then I see that sys_open of file creation
on rootfs returns -ENOENT.

Alon.
