From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 27 Jan 2014 12:17:56 +0000
Subject: Re: [PATCH V3 0/3] ARM: shmobile: lager: Add USB support
Message-Id: <52E64E74.9000502@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1390602529-11867-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1390602529-11867-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 27/01/14 10:02, Valentine wrote:
> On 01/27/2014 01:59 PM, Ben Dooks wrote:
>> On 24/01/14

[snip]

>> Hi, when doing this have you come across a problem where the OHCI
>> controller on USB0 fails to start with an initialisation error? I
>> think it is something to do with the bridge setup but have yet to
>> have enough time to look into this issue.
>>
>
> All PCI ports have worked fine for me.
> Please, check that the SW5/SW6 pins are set correctly on your board.

SW5 is at position 1
SW6 is at position 1

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
