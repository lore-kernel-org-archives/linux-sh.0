From: Jeremy Kerr <jeremy.kerr@canonical.com>
Date: Mon, 07 Feb 2011 07:00:30 +0000
Subject: Re: [RFC, PATCH 3/3] clk: add warnings for incorrect enable/prepare semantics
Message-Id: <201102071500.31276.jeremy.kerr@canonical.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<1297058877.800990.238556019385.3.gpush@pororo>
	<AANLkTinq=HieqGUFthm04F21RuLijg2mZH+eoan9p5HN@mail.gmail.com>
In-Reply-To: <AANLkTinq=HieqGUFthm04F21RuLijg2mZH+eoan9p5HN@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Jassi,

> Shouldn't the prepare_count be checked against 0 ?

Yes, you're right, it should be clk->prepare_count = 0.

Will update for the next revision.

Cheers,


Jeremy
