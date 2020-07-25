From: Markus Elfring <Markus.Elfring@web.de>
Date: Sat, 25 Jul 2020 11:27:56 +0000
Subject: Re: [PATCH] sh: sh4: Fix reference count leak in sq_dev_add
Message-Id: <12d84b44-96c8-ee11-fff8-b1a7ea6b0d7c@web.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1595636246-15392-1-git-send-email-wang.yi59@zte.com.cn>
In-Reply-To: <1595636246-15392-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Yi Wang <wang.yi59@zte.com.cn>, Liao Pingfang <liao.pingfang@zte.com.cn>, linux-sh@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Rich Felker <dalias@libc.org>, Wang Liang <wang.liang82@zte.com.cn>, Xue Zhihong <xue.zhihong@zte.com.cn>, Yoshinori Sato <ysato@users.sourceforge.jp>

> kobject_init_and_add() takes reference even when it fails. If this
> function returns an error, kobject_put() must be called to properly
> clean up the memory associated with the object.

* An imperative wording can be preferred for the change description,
  can't it?

* Would you like to add the tag “Fixes” to the commit message?

Regards,
Markus
