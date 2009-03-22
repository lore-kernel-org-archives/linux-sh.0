From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 22 Mar 2009 11:13:17 +0000
Subject: Re: Kernel fails on Dreamcast - results of bisection
Message-Id: <20090322111317.GA16675@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1237675045.27611.23.camel@localhost.localdomain>
In-Reply-To: <1237675045.27611.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Mar 21, 2009 at 11:39:25PM +0000, Adrian McMenamin wrote:
> (I am now getting a lot of messages about failures of the udev script -
> possibly because I have just turned a lot of debugging stuff on - in any
> case the system does boot and works with that commit reverted).
> 
These messages are about allocation failures, the exact same thing that
leads to your OOM. (It does help to actually read the error messages
rather than dismiss them as superfluous). While it is possible that the
timer patch pushed you over the edge on memory allocation, nothing else
suggests that you have pinpointed the real problem. Obviously udev did
not used to hit allocation failures, and we need to know when that
started, or what you did to your environment that causes it.
