From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Thu, 23 Jul 2009 08:00:36 +0000
Subject: Re: [PATCH] sh: kfr2r09 board support - zImage flash boot
Message-Id: <20090723170036.136480f7.iwamatsu@nigauri.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090722162637.18222.7149.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090722162637.18222.7149.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi! Magnus.

On Thu, 23 Jul 2009 01:26:37 +0900
Magnus Damm <magnus.damm@gmail.com> wrote:

> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch adds zImage flash boot support to the kfr2r09 board.
> 
> The flash boot code is a Partner Jet script converted into
> assembly using macros. If CONFIG_ZIMAGE_BOOT_LOADER is set
> then the resulting zImage should be burned to the boot vector
> of the CS0 flash.
> 
> The Partner Jet script can also be used stand alone with the
> Partner Jet JTAG debugger to setup the RAM and allow the zImage
> to execute from RAM without burning the zImage to flash.
> 
> A simple initramfs based user land is booted in less than a second.

Is not U-Boot of R2R yet implemented?

Best regards,
 Nobuhiro

-- 
Nobuhiro Iwamatsu
	GPG ID: 3170EBE9
