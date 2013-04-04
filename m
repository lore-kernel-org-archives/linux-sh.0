From: Simon Horman <horms@verge.net.au>
Date: Thu, 04 Apr 2013 02:00:20 +0000
Subject: APE6EVM and Runtime PM
Message-Id: <20130404020019.GA7163@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Magnus,

in the course of looking look at consolidating our defconfigs I
noticed that SMSC ethernet and rcar_thermal seem seem to not work when
runtime PM is enabled.

I'm wondering if you have any ideas of what might be the cause of this
or if you could give me some guidance on investigating this problem.

I assume that it relates to a clock or clocks not being enabled.
