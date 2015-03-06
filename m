From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 06 Mar 2015 10:41:08 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: Remove r8a7791 platform_device_id entry
Message-Id: <CACRpkda5ozg96kGrDXtvUgcuaQ0e6S=fhqJhdbfaddPg-AHSbQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424016101-10111-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424016101-10111-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Feb 15, 2015 at 5:01 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> The r8a7791 platform is now DT-only, the driver doesn't need to match
> platform devices by name anymore. Remove the corresponding
> platform_device_id entry.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Patch applied with all ACKs.

Yours,
Linus Walleij
