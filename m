From: Christoph Hellwig <hch@lst.de>
Date: Tue, 14 Jul 2020 12:18:46 +0000
Subject: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-Id: <20200714121856.955680-1-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200324162633.754714-1-hch@lst.de>
In-Reply-To: <20200324162633.754714-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Yoshinori and Rich,

can you take a look and possibly pick up the series below that untangles
and sorts out minor issues with the sh ioremap and dma code?

I sent this out a few times, but never got an answer.  If you don't
want to pick up the series I can also take it through one of my trees
if I get ACKs.
