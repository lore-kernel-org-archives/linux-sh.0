From: David Miller <davem@davemloft.net>
Date: Tue, 14 Jan 2014 07:29:35 +0000
Subject: Re: [PATCH] sh_eth: fix garbled TX error message
Message-Id: <20140113.232935.776174177146650322.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201401110241.49471.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201401110241.49471.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 11 Jan 2014 02:41:49 +0300

> sh_eth_error() in case of a TX error tries to print a message using 2 dev_err()
> calls with the first string not finished by '\n', so that the resulting message
> would inevitably come out garbled, with something like "3net eth0: " inserted
> in the middle.  Avoid that by merging 2 calls into one.
> 
> While at it, insert an empty line after the nearby declaration.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied, thanks.

I don't think this is really -stable material, sorry.
