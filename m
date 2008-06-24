From: "Adrian McMenamin" <adrian@newgolddream.dyndns.info>
Date: Tue, 24 Jun 2008 10:59:07 +0000
Subject: Re: [PATCH] maple: tidy  maple_driver code by removing redundant
Message-Id: <5703.85.118.17.158.1214305147.squirrel@newgolddream.dyndns.info>
List-Id: <linux-sh.vger.kernel.org>
References: <1213559289.22707.15.camel@localhost.localdomain>
    <20080624040128.GB22526@linux-sh.org>
In-Reply-To: <20080624040128.GB22526@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>, lkml <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

On Tue, June 24, 2008 5:01 am, Paul Mundt wrote:
> On Sun, Jun 15, 2008 at 08:48:09PM +0100, Adrian McMenamin wrote:
>> The connect and disconnect functions are unnecessary - everything they
>> do can be
>> accomplished in the initial probe - so remove them.
>>
>> Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
>
> Applied, thanks.
>
Paul,

Just to note that this (http://lkml.org/lkml/2008/6/15/122) will break the
keyboard driver unless this (http://lkml.org/lkml/2008/6/15/121) is also
applied.

I haven't heard back from Dmitry on the keyboard patch yet.

Adrian

