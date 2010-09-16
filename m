From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 16 Sep 2010 08:20:33 +0000
Subject: Re: [PATCH 09/18] sh: kill big kernel lock
Message-Id: <20100916082033.GC12314@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1284492909-7147-10-git-send-email-arnd@arndb.de>
In-Reply-To: <1284492909-7147-10-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 14, 2010 at 09:35:00PM +0200, Arnd Bergmann wrote:
> The only BKL user in arch/sh protects a single bit,
> so we can trivially replace it with test_and_set_bit.

Applied, thanks.
