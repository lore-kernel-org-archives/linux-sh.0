From: Simon Horman <horms@verge.net.au>
Date: Fri, 19 Jun 2015 00:27:04 +0000
Subject: Re: [PATCH v2 7/7] ARM: shmobile: armadillo800eva dts: Add pinctrl and gpio-hog for lcdc0
Message-Id: <20150619002703.GC32130@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
 <1434530336-15073-8-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1434530336-15073-8-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jun 17, 2015 at 10:38:56AM +0200, Geert Uytterhoeven wrote:
> Configure pinctrl and a GPIO-controller board mux for LCD use.
> This allows the armadillo800eva board staging code to enable lcdc0.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks Geert,

As Greg has now taken patches 1 - 6 I have queued this up.
