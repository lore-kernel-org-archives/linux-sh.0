From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 18 Jan 2011 10:59:08 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh73a0 CPGA fix for IrDA MSTP
Message-Id: <20110118105908.GA19486@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101222061405.25163.82564.sendpatchset@t400s>
In-Reply-To: <20101222061405.25163.82564.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 18, 2011 at 05:48:17PM +0900, Magnus Damm wrote:
> Fix a typo for the sh73a0 CPGA code dealing with the IrDA
> hardware block on the AG5EVM board.

On Tue, Jan 18, 2011 at 05:53:06PM +0900, Magnus Damm wrote:
> Fix the M3 field offset for the FRQCRA register
> in the sh73a0 CPGA. It should be 12, not 8.

Applied, thanks.
