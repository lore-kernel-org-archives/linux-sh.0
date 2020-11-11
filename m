From: Rob Landley <rob@landley.net>
Date: Wed, 11 Nov 2020 16:45:38 +0000
Subject: Re: [PATCH v1] sh: Drop ARCH_NR_GPIOS definition
Message-Id: <10b4dc8e-db87-3f78-3ab7-e08469b9fe55@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20201012154050.68039-1-andriy.shevchenko@linux.intel.com>
 <20201109121333.GC4077@smile.fi.intel.com>
In-Reply-To: <20201109121333.GC4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-gpio <linux-gpio@vger.kernel.org>

On 11/9/20 6:13 AM, Andy Shevchenko wrote:
> On Mon, Oct 12, 2020 at 06:40:50PM +0300, Andy Shevchenko wrote:
>> The default by generic header is the same, hence drop unnecessary definition.
> 
> Any comment on this?

Acked-by: Rob Landley <rob@landley.net>

It's in the stack I forwarded to Rich to look at this weekend.

Rob
