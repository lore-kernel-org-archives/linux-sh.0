From: Christoph Hellwig <hch@infradead.org>
Date: Mon, 14 May 2018 12:03:43 +0000
Subject: Re: [PATCH] sh: switch to NO_BOOTMEM
Message-Id: <20180514120343.GB5265@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20180511134559.13464-1-robh@kernel.org>
In-Reply-To: <20180511134559.13464-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Yoshinori Sato <ysato@users.sourceforge.jp>

> unflattening could also fix this, but removing bootmem is desired. So
> enable NO_BOOTMEM on SH like other architectures have done.

Can you send out similarly shoot in the wild conversion for the
remaining architectures while you are at it?  We still seem to be
missing: alpha, c6x, hexagon, ia64, m68k, mips, nios2 and unicore32.
