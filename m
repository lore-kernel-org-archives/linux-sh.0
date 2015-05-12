From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 12 May 2015 07:28:40 +0000
Subject: Re: [PATCH 2/2] pinctrl: sh-pfc: Remove r8a73a4 platform_device_id entry
Message-Id: <CACRpkdYS1K5x_Wj3ABrX5n13+JRNfCcqPuzdjVuvQo-+gB_K9Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430216107-31501-1-git-send-email-geert+renesas@glider.be>
	<1430216107-31501-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430216107-31501-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Tue, Apr 28, 2015 at 12:15 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> As of commit 9d07d414d4c33d86 ("ARM: shmobile: r8a73a4: ape6evm: Remove
> legacy platform"), r8a73a4 is only supported in generic DT-only ARM
> multi-platform builds.  The driver doesn't need to match platform
> devices by name anymore, hence remove the corresponding
> platform_device_id entry.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied with all ACKs.

Yours,
Linus Walleij
