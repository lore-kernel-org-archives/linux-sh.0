From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Tue, 30 Sep 2014 04:47:32 +0000
Subject: Re: [PATCH 0/2] Add VSP1 devices to DT for r8a7790 and r8a7791
Message-Id: <542A35E4.2030906@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1410651385-13090-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1410651385-13090-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Hi Laurent,

We are testing the upstream linux version on Lager.
I have tried to test VSP1 driver on r8a7790(Lager).
But I don't know how to test it.
Could you please tell the method to test it?

Best Regards,
Jinso/Cao Minh Hiep.

On 2014年09月14日 08:36, Laurent Pinchart wrote:
> Hello,
>
> This patch set simply adds all available VSP1 devices to the r8a7790 and
> r8a7791 .dtsi.
>
> Laurent Pinchart (2):
>    ARM: shmobile: r8a7790: Add VSP1 devices to DT
>    ARM: shmobile: r8a7791: Add VSP1 devices to DT
>
>   arch/arm/boot/dts/r8a7790.dtsi | 51 ++++++++++++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/r8a7791.dtsi | 39 ++++++++++++++++++++++++++++++++
>   2 files changed, 90 insertions(+)
>

