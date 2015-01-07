From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 07 Jan 2015 21:08:11 +0000
Subject: Re: [PATCH] next: sh: Fix compile error
Message-Id: <54ADA03B.4060708@de.ibm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1420662748-28129-1-git-send-email-linux@roeck-us.net> <20150107210419.GH5280@linux.vnet.ibm.com>
In-Reply-To: <20150107210419.GH5280@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: paulmck@linux.vnet.ibm.com, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Am 07.01.2015 um 22:04 schrieb Paul E. McKenney:
> On Wed, Jan 07, 2015 at 12:32:28PM -0800, Guenter Roeck wrote:
>> Commit a91ed664749c ("kernel: tighten rules for ACCESS ONCE") results in a
>> compile failure for sh builds with CONFIG_X2TLB enabled.
>>
>> arch/sh/mm/gup.c: In function 'gup_get_pte':
>> arch/sh/mm/gup.c:20:2: error: invalid initializer
>> make[1]: *** [arch/sh/mm/gup.o] Error 1
>>
>> Replace ACCESS_ONCE with READ_ONCE to fix the problem.
>>
>> Fixes: a91ed664749c ("kernel: tighten rules for ACCESS ONCE")
>> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

Applied to my tree, thanks.

Christian

