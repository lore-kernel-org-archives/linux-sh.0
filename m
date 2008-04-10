From: "Alon Bar-Lev" <alon.barlev@gmail.com>
Date: Thu, 10 Apr 2008 16:51:36 +0000
Subject: Re: SH7751R - STRANGE initramfs/rootfs behavior
Message-Id: <9e0cf0bf0804100951i3c244e86rbe4c649c50dd3548@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <9e0cf0bf0804070616y72f1bf4er6dcbb23188937543@mail.gmail.com>
In-Reply-To: <9e0cf0bf0804070616y72f1bf4er6dcbb23188937543@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Any tip how I can debug this further?
Where can endianess affect memory access...

Thanks!

On 4/8/08, Alon Bar-Lev <alon.barlev@gmail.com> wrote:
> On 4/8/08, Paul Mundt <lethal@linux-sh.org> wrote:
>  > Indeed, I meant more in terms of big-endian on SH. It wouldn't surprise
>  >  me if there was a path where the swabbing or something else is broken.
>  >  Especially on SH-4, I don't know anyone that has tested it recently.
>  >
>  >  I've noticed the CRC errors on the SH-2A regardless of what we have in
>  >  the cpio, but did not have time to investigate it further at the time.
>  >
>
>
> Thank you for replying!
>  I cannot set the board to little endian as I try to migrate existing working
>  board configuration with 2.4 kernel to 2.6.
>  Can you please help me understand where should I look for issues?
>  Please note that if I skip decompression part, I have issues with creating
>  files on rootfs, this seems unrelated, so the problem is somewhere else.
>
>  Thanks!
>
> Alon.
>
