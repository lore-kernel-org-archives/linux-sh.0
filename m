From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 05 Feb 2014 09:31:45 +0000
Subject: Re: [PATCH 2/3] PCI: rcar: add error interrupt handling
Message-Id: <52F20501.6030909@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1390902468-7753-1-git-send-email-ben.dooks@codethink.co.uk> <1390902468-7753-3-git-send-email-ben.dooks@codethink.co.uk> <CANqRtoRy9bEUMCDqMtbfa3NvLuuLxda5RN=CZs9V37caNnwdWw@mail.gmail.com>
In-Reply-To: <CANqRtoRy9bEUMCDqMtbfa3NvLuuLxda5RN=CZs9V37caNnwdWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@lists.codethink.co.uk, Valentine Barshak <valentine.barshak@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>

On 05/02/14 08:50, Magnus Damm wrote:
> On Tue, Jan 28, 2014 at 6:47 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>> Add option to enable interrupts to report any errors from
>> the AHB-PCI bridge to help find any issues with the bridge
>> when in use.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

>
> Thanks for your patches. Handling errors sounds good. About this
> particular one, I'm not so keen on introducing Kconfig options for
> each driver. Instead I'd prefer to handle this during runtime or as
> Valentine suggested using CONFIG_PCI_DEBUG.

Ok, I will change to using that.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
