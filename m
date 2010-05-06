From: Paul Mundt <paul.mundt@renesas.com>
Date: Thu, 06 May 2010 05:05:26 +0000
Subject: Re: Missing of "Uncompressing Linux... " message at boot sequence
Message-Id: <20100506050526.GC31681@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4BDFCEF4.8010607@dcl.info.waseda.ac.jp>
In-Reply-To: <4BDFCEF4.8010607@dcl.info.waseda.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 05, 2010 at 09:49:57PM -0700, Paul Mundt wrote:
> On Tue, May 04, 2010 at 04:38:28PM +0900, Hitoshi Mitake wrote:
> > If you have a plan to revive the message, I'd like to co-operate.
> > Because I'm working on new board support, serial output is a big problem 
> > for me.
> > 
> I'll have a look at restoring it, but be forewarned that there will
> likely be outstanding sh-bios issues. If you're able to assist with
> debugging this then of course I have no problem with reinstanting this
> sort of support.

Also note that the earlyprintk stuff should largely make this irrelevant
for most people. The cases where the earlyprintk code ends up being
useless is primarily with memory initialization or getting the serial
port up on a new CPU (although the latter case is not so exceptional
anymore), so it's quite possible that simply turning off the sh-bios
stuff and using the earlyprintk code as-is will be sufficient for you to
get early messages.
