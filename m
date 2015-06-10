From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 10 Jun 2015 11:57:01 +0000
Subject: Re: [PATCH v5 0/3] Add Renesas R8A7794 PFC support
Message-Id: <5578260D.7040704@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4547979.iqiS3iOv3s@wasted.cogentembedded.com> <CACRpkdYLYeb7X52G7Et-6rXVpKpk67zAXB-UBO-vFFtrtLp+9Q@mail.gmail.com>
In-Reply-To: <CACRpkdYLYeb7X52G7Et-6rXVpKpk67zAXB-UBO-vFFtrtLp+9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

Hello.

On 6/10/2015 11:17 AM, Linus Walleij wrote:

>>     Here's the set of 3 patches against the 'devel' branch of Linus Walleij's
>> 'linux-pinctrl.git' repo. Here we add the PFC support for the Renesas R8A7794
>> SoC. The patches teaching the PFC driver to deal with "holes" in the pin array
>> are necessary for these patches to work (I didn't create a single series due to
>> the different patch versions of these 2 series).

    Since no other R8A7794 patches have been merged yet, you can even merge 
these patches right away.

>> [1/3] sh-pfc: add R8A7794 PFC support
>> [2/3] sh-pfc: r8a7794: add MMCIF pin groups
>> [3/3] sh-pfc: r8a7794: add SDHI pin groups

> Waiting for Laurent to review these patches.

    The previous version was already ACKed by Laurent, and there was no 
significant changes since then.

> Yours,
> Linus Walleij

WBR, Sergei

