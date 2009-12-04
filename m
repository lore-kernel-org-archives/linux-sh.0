From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 04 Dec 2009 03:51:47 +0000
Subject: Re: [PATCH] sh: fix build with FPU disabled
Message-Id: <aec7e5c30912031951j3a4abd24hb4a30aac0ac430e3@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20091203122041.9836.36225.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091203122041.9836.36225.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 4, 2009 at 6:12 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Thu, Dec 03, 2009 at 09:20:41PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> This patch makes sure platforms lacking FPU build
>> Without this sh7722 fails to build.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>
> This was fixed 8 days ago.

Ok, this is just me being confused moving back and forth due to the
cache issues.

/ magnus
