From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 18 Jun 2013 09:05:43 +0000
Subject: Re: [PATCH v7 0/3] SH pinctrl DT support
Message-Id: <CACRpkdbFEKJxQfvT4xR4z1iymHPmbbCYJriVPD95P_L0oCC6Jg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1371495003-11185-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<CACRpkdZh709J3pFsfbReQ20LU5W0Q1HacE0ZpssWXofKTJJ6pQ@mail.gmail.com>
	<51C01FAF.8050006@imgtec.com>
In-Reply-To: <51C01FAF.8050006@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Hogan <james.hogan@imgtec.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>

On Tue, Jun 18, 2013 at 10:51 AM, James Hogan <james.hogan@imgtec.com> wrote:

> Should we be standardizing the pins/groups/function properties too,
> since the strings are pretty much passed straight through? The usage
> seems pretty similar between the drivers I've seen (except ugly vendor
> prefixes), so we could presumably get away with a single implementation
> of dt_node_to_map?

This is an orthogonal issue I'd say.

Basically this goes back to the quite prolonged discussion about
device tree bindings and the fact that we added the
.dt_node_to_map() and .dt_free_map() functions in the
first place.

I'd be happy to consolidate these mapping functions where
possible, by moving to the core, basically.

But that would be a separate patch series.... interested? ;-)

Yours,
Linus Walleij
