From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 23 May 2012 06:32:18 +0000
Subject: Re: [PATCH 01/03] clockevents: Make clockevents_config() a global symbol
Message-Id: <20120523063218.GB11860@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20120509143926.27521.20342.sendpatchset@w520>
 <20120509143934.27521.46553.sendpatchset@w520>
In-Reply-To: <20120509143934.27521.46553.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, horms@verge.net.au, linux-sh@vger.kernel.org, johnstul@us.ibm.com, rjw@sisk.pl, gregkh@linuxfoundation.org, olof@lixom.net, tglx@linutronix.de

On Wed, May 09, 2012 at 11:39:34PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Make clockevents_config() into a global symbol to allow it
> to be used by compiled-in clockevent drivers. This is needed
> by drivers that want to update the timer frequency after
> registration time.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Any update on this?
