From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 11 Mar 2009 08:29:33 +0000
Subject: Re: [PATCH] sh: improve sh7785lcr power off code
Message-Id: <20090311082933.GE6281@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090311081426.2031.70713.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090311081426.2031.70713.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 11, 2009 at 05:14:26PM +0900, Magnus Damm wrote:
> Improve the sh7785lcr power off implementation to
> never return. It takes some time before the board
> is actually powered off, just hang after asking
> the harware to power down.
> 
> This removes the serial port garbage printout.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Applied.
