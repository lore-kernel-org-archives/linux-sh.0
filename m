From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 21 Jan 2011 09:40:42 +0000
Subject: Re: Locking in the clk API
Message-Id: <20110121094042.GD13235@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111091607.GI12552@n2100.arm.linux.org.uk>
	<201101111744.59712.jeremy.kerr@canonical.com>
	<20110111103929.GN24920@pengutronix.de>
	<AANLkTinHL9X_bqMPR=W8Va01O4xngUnpGCkCiE3xEdiQ@mail.gmail.com>
	<4D386ABF.9060908@fluff.org>
	<20110120190822.GK6335@n2100.arm.linux.org.uk>
	<4D3932B4.8010904@codeaurora.org>
In-Reply-To: <4D3932B4.8010904@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Jan 20, 2011 at 11:16:04PM -0800, Saravana Kannan wrote:
> This suggestion looked promising till I realized that clk_set_rate()  
> will still be atomic. clk_set_rate() will need to enable/disable the  
> PLLs depending on which PLLs the rates are derived from. So, the locking  
> in clk_prepare/unprepare() still has to be atomic since the "slow stuff"  
> is shared with clk_set_rate().

Who calls clk_set_rate() from an atomic context?  Do we know whether
anyone does?
