From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 16 Nov 2010 08:48:26 +0000
Subject: Re: [PATCH v2] ARM: mach-shmobile: ap4evb: add fsib 44100Hz rate fixup
Message-Id: <20101116084826.GC1330@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pd3wmt65q.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pd3wmt65q.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 16, 2010 at 04:34:34PM +0900, Kuninori Morimoto wrote:
> FSIDIVB is used when HDMI sound is 48kHz,
> but it should be disabled when 44.1kHz.
> And fsidiv_set_rate do that if selected rate is same as parent rate.
> This patch select parent rate to fdiv_clk when 44.1kHz
> 
Ok, now that I now what this is doing, this is also totally bogus.

You have hard-coded some bizzare enable/disable logic in the middle of
the ->set_rate() op that completely blindsides the refcounting. This
might be ok in practice since you probably only have 1 user of the clock
at the moment, but consider what would happen if you had 2 users and one
just happens to randomly turn the clock off on the other. We do
refcounting and API abstraction for a reason. Any time you are deviating
from the API, you are probably doing something wrong.

Furthermore, what does any of this have to do with rate setting? And if
it has nothing to do with rate setting, why would you bother adding it to
the ->set_rate op?

Disabling of the parent clock will happen automatically by the clock
framework when the refcount on it drops. Disabling of the sibling clock
will happen automatically when its refcount drops, too. It seems that all
of your use cases here can be fixed up by simply using proper
clk_get/put() and enable/disable() refcounting.

It is never acceptable to bypass the refcount, under any situation.
