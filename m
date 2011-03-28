From: Daniel Palmer <me@danielpalmer.co.uk>
Date: Mon, 28 Mar 2011 14:08:33 +0000
Subject: Re: [PATCH 2/2] sh: Add sh_io_port_base check in __ioport_map function
Message-Id: <4D909661.80107@danielpalmer.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1301200307-5321-2-git-send-email-iwamatsu@nigauri.org>
In-Reply-To: <1301200307-5321-2-git-send-email-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 27/03/11 08:45, Nobuhiro Iwamatsu wrote:
> I think that this is other problem for pata_artop.
> This patch fix calculation of address.
>
> Best regards,
>    Nobuhiro
>    

With some advice from another Landisk/USL-5P user..

Changing a line in arch/sh/kernel/ioport.c

const unsigned long sh_io_port_base __read_mostly = 0xfe240000;

Seems to fix PCI.

All PCI seems to be broken in 2.6.38.
Loading 8139cp for the ethernet controller makes the board hang.

Also I have asked on the linux-ide list. PATA_ARTOP is working on other 
boards.
