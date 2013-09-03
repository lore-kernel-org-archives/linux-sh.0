From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 03 Sep 2013 12:21:57 +0000
Subject: Re: [RFC 06/10] ARM: shmobile: r8a7790: add I2C clock
Message-Id: <5225D465.4080001@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1377866264-21110-7-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1377866264-21110-7-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 03-09-2013 11:21, Ulrich Hecht wrote:

> <sergei.shtylyov@cogentembedded.com> wrote:
>> On 08/30/2013 04:37 PM, Ulrich Hecht wrote:
>>> --- a/arch/arm/mach-shmobile/clock-r8a7790.c
>>> +++ b/arch/arm/mach-shmobile/clock-r8a7790.c
>>> @@ -181,6 +182,7 @@ static struct clk div6_clks[DIV6_NR] = {
>>>
>>>    /* MSTP */
>>>    enum {
>>> +       MSTP931, MSTP930, MSTP929, MSTP928,

>>     Please break the line after "MSTP930,".

> Could you explain what the system behind this is?

    Every line should start with MSTPxx0 and end with MSTPxx9, ideally.
Although, I see this file doesn't always follow this rule, so you can ignore 
me. :-)

> CU
> Uli

WBR, Sergei

