From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 19 Sep 2014 17:18:18 +0000
Subject: Re: [PATCH v2 1/5] i2c: Don't start transfers when suspended
Message-Id: <20140919171818.GA2874@katana>
List-Id: <linux-sh.vger.kernel.org>
References: <1405608520-5644-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1405608520-5644-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Jul 17, 2014 at 04:48:36PM +0200, Bastian Hecht wrote:
> i2c transfer requests come in very uncontrolled, like from interrupt routines.
> We might be suspended when this happens. To avoid i2c timeouts caused by
> powered down busses we check for suspension.
> 
> Several bus drivers handle this problem on their own. We can clean things up
> by moving the protection mechanism into the core.
> 
> Signed-off-by: Bastian Hecht <hechtb@gmail.com>

Dropping this series due to the comments. I am not sure if it is worth
to add information about the clients being "normally" suspendable or
not. Thanks Bastian for the effort, though.

