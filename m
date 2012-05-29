From: David Miller <davem@davemloft.net>
Date: Tue, 29 May 2012 08:17:11 +0000
Subject: Re: [PATCH v5 1/6] net: sh_eth: remove unnecessary function
Message-Id: <20120529.041711.866739766279184452.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <4FC48570.8040204@renesas.com>
In-Reply-To: <4FC48570.8040204@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yoshihiro.shimoda.uh@renesas.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org


It is not appropriate to submit cleanups and feature additions for the
'net-next' tree at this time.  That is only valid when I open the
net-next tree back up which will be shortly after the merge window
closes.

If you have bug fixes to submit for the 'net' tree, you must split
them off from these cleanups and submit them seperately.

