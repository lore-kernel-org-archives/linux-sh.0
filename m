From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 03 Dec 2013 10:13:35 +0000
Subject: Re: [PATCH 10/11] ARM: shmobile: koelsch: pinctrl map for MSIOF0
Message-Id: <CACRpkdY7XppOpgCS4JmQFKhYPSHk4-sdse8wsQ2dj72TtoL8WA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp>
	<1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
	<1385921962-19843-10-git-send-email-takasi-y@ops.dti.ne.jp>
In-Reply-To: <1385921962-19843-10-git-send-email-takasi-y@ops.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: takasi-y@ops.dti.ne.jp
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org

On Sun, Dec 1, 2013 at 7:19 PM,  <takasi-y@ops.dti.ne.jp> wrote:

> From: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
>
> Enable msifo0_{clk,sync,rx,tx} pins for MSIOF driver.
>
> Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>

If this device is registered from the device tree, the pin control
business can also be done from the device tree.

NAK.

Yours,
Linus Walleij
