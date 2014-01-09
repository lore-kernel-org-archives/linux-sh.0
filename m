From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 09 Jan 2014 14:42:11 +0000
Subject: Re: lager - non-booting latest horms' devel branch
Message-Id: <52CEB543.1020205@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <52CE8BC0.7060306@codethink.co.uk>
In-Reply-To: <52CE8BC0.7060306@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 09/01/14 12:21, Geert Uytterhoeven wrote:
> Hi Ben,
>
> On Thu, Jan 9, 2014 at 12:45 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>> I am using the devel branch from Simon Horms' git tree, SHA1
>> 3da593ea7d797d9f59bd6ed1ee629fab681d7a23 and not seeing a
>> boot when using the multi arch defconfig and device-tree.
>>
>> The board does not produce any console output so I am not
>> sure what is going on. Has anyone else had issues with using
>> the fdt-only boot?

Ok, having looked at this we have the following issues:

sh_cmt sh   _cmt.0: cannot get clock...4
sh_cmt: probe of sh_cmt.0 failed with error -2

sh-sci.4: can't get iclk.
sh-sci: probe of sh-sci.4 failed with error -2

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
