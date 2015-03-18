From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 18 Mar 2015 01:16:06 +0000
Subject: Re: [PATCH v3 4/4] pinctrl: sh-pfc: Use u32 to store register addresses
Message-Id: <CACRpkdYcQsaNve6Z94DX2nV8DKT3ZWoVU2AVn-PsbJJs8gYKvw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1426154956-26583-1-git-send-email-geert+renesas@glider.be>
	<1426154956-26583-5-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1426154956-26583-5-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Thu, Mar 12, 2015 at 11:09 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

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
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> v3:
>   - Add Acked-by,

Patch applied.

Yours,
Linus Walleij
