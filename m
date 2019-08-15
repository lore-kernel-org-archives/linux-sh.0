From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Thu, 15 Aug 2019 00:59:52 +0000
Subject: Re: [PATCH] sh: Drop -Werror from kernel Makefile
Message-Id: <ea8c7d68-d799-6a7e-9606-e011951bf22e@embeddedor.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1564971263-21562-1-git-send-email-linux@roeck-us.net>
 <87a7cdpi06.wl-ysato@users.sourceforge.jp>
 <ee8b2e37-643d-9b29-b7de-d83c7739c3a0@roeck-us.net>
In-Reply-To: <ee8b2e37-643d-9b29-b7de-d83c7739c3a0@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Guenter,

On 8/13/19 8:18 AM, Guenter Roeck wrote:
> 
> Please note that _mainline_ builds are currently broken.
> 

This should be fixed now:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?idAde59634046b19cd53a1983594a95135c656997

Thanks
--
Gustavo
