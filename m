From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 12 Mar 2015 01:02:51 +0000
Subject: Re: [PATCH v2 4/4] pinctrl: sh-pfc: Use u32 to store register addresses
Message-Id: <3725535.iu1CkyQgCh@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1425985583-26279-1-git-send-email-geert+renesas@glider.be> <1425985583-26279-5-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1425985583-26279-5-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Tuesday 10 March 2015 12:06:23 Geert Uytterhoeven wrote:
> Currently all PFC registers lie in low 32-bit address space. Hence use
> u32 instead of unsigned long to store PFC register addresses in pinctrl
> tables.  All calculations of virtual addresses use a phys_addr_t
> intermediate, so we know where to add an offset if the 32-bit assumption
> ever becomes false.
> 
> While this doesn't impact 32-bit builds, it would save ca. 7 KiB on a
> 64-bit shmobile_defconfig kernel.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart

