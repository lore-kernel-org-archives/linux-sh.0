From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 06 Mar 2009 05:54:53 +0000
Subject: Re: [PATCH v2] sh: multiple vectors per irq - sh7763
Message-Id: <20090306055453.GA14260@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49B0B4EA.1090506@renesas.com>
In-Reply-To: <49B0B4EA.1090506@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 06, 2009 at 02:30:18PM +0900, Nobuhiro Iwamatsu wrote:
> Sorry, I sent old other patch.
> I resend new patch.
> 
Looks like it was just the RTC IRQ that was inadvertently dropped, I
just applied the fix on top of the previous patch.
