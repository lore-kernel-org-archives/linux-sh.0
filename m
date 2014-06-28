From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 28 Jun 2014 00:22:19 +0000
Subject: Re: [PATCH 2/2] PCI: host: pcie-rcar: Style and formatting changes.
Message-Id: <53AE0ABB.4010501@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1403888155-9709-1-git-send-email-phil.edworthy@renesas.com> <1403888155-9709-3-git-send-email-phil.edworthy@renesas.com> <20140628001448.GE27128@verge.net.au> <20140628001542.GA32431@verge.net.au>
In-Reply-To: <20140628001542.GA32431@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org, linux-sh@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>

Hello.

On 06/28/2014 04:15 AM, Simon Horman wrote:

>>> This patch just makes symbol and function name changes to avoid
>>> potential conflicts, along with minor formatting changes.
>>> The only other change is to replace an arg passed into a func
>>> with a local variable.

>>> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
>>> ---
>>>   drivers/pci/host/pcie-rcar.c | 131 ++++++++++++++++++++++---------------------
>>>   1 file changed, 67 insertions(+), 64 deletions(-)

>>> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
>>> index 680a8cc..efdea07 100644
>>> --- a/drivers/pci/host/pcie-rcar.c
>>> +++ b/drivers/pci/host/pcie-rcar.c
[...]
>>> @@ -318,14 +319,15 @@ static struct pci_ops rcar_pcie_ops = {
>>>   	.write	= rcar_pcie_write_conf,
>>>   };
>>>
>>> -static void rcar_pcie_setup_window(int win, struct resource *res,
>>> -				   struct rcar_pcie *pcie)
>>> +static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie)
>>>   {
>>> +	struct resource *res = &pcie->res[win];
>>> +
>>
>> The removal of the res parameter is not in keeping with the changelog.
>> Could you break it out into a separate patch?
>
> Sorry, I see that it is mentioned in the changelog.
> But could you split the patch all the same?

    I agree. Generally, you should not mix several changes of a different 
nature in one patch.

WBR, Sergei

