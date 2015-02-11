From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 11 Feb 2015 10:47:31 +0000
Subject: Re: [PATCH v2 1/2] shdmac: use SET_RUNTIME_PM_OPS()
Message-Id: <54DB3343.1030009@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <9005734.b9UuUHqyUV@wasted.cogentembedded.com>
In-Reply-To: <9005734.b9UuUHqyUV@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 2/11/2015 4:23 AM, Vinod Koul wrote:

>> Use SET_RUNTIME_PM_OPS() to initialize the runtime PM method pointers in the
>> 'struct dev_pm_ops';  since that macro doesn't  do anything  if CONFIG_PM is
>> not defined, we have  to move #ifdef up to also cover the runtime PM methods
>> in order to avoid compilation warnings.

> Applied both, thanks.

    Thanks to you! Will they get into 3.20?

> Btw shdmac is NOT a subsystem name!!

    Sorry, I usually don't add the subsystem names, leaving that to the 
maintainers who want (or don't want) to do it.

WBR, Sergei

