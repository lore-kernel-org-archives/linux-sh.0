From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 23 Jul 2009 08:44:16 +0000
Subject: Re: [PATCH] sh: kfr2r09 board support - zImage flash boot
Message-Id: <aec7e5c30907230144g34e8ac1anf40fa4f058b36953@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090722162637.18222.7149.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090722162637.18222.7149.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Iwamatsu-san,

On Thu, Jul 23, 2009 at 5:00 PM, Nobuhiro Iwamatsu<iwamatsu@nigauri.org> wrote:
> On Thu, 23 Jul 2009 01:26:37 +0900
> Magnus Damm <magnus.damm@gmail.com> wrote:
>> This patch adds zImage flash boot support to the kfr2r09 board.
>
> Is not U-Boot of R2R yet implemented?

I don't know the status of U-Boot on R2R by itself, but last time I
checked U-boot did not have enough hardware support for the kfr2r09
board to boot easily. This board does not have any ethernet
controller. And no USB host.

To easily boot the kfr2r09 board we need USB gadget support with
r8a66597 together with USB ethernet + serial combo gadget driver and
maybe MMC as well. And since we need them under Linux anyway we may as
well reuse our drivers for booting together with kexec.

Cheers,

/ magnus
