From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Thu, 20 Jan 2011 18:57:07 +0000
Subject: Re: Locking in the clk API
Message-Id: <20110120185707.GJ6335@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111031552.GJ3760@linux-sh.org>
	<201101111211.30172.jeremy.kerr@canonical.com>
	<20110111045423.GP3760@linux-sh.org> <4D3863AC.4020209@fluff.org>
In-Reply-To: <4D3863AC.4020209@fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Jan 20, 2011 at 04:32:44PM +0000, Ben Dooks wrote:
> I would vote for all clk lookup and reference counting code be made
> sleep-able and define it as such.

Always has been and probably always will be.
