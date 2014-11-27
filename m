From: Takanari Hayama <taki@igel.co.jp>
Date: Thu, 27 Nov 2014 01:01:47 +0000
Subject: Re: [PATCH 2/2] v4l: vsp1: Always enable virtual RPF when BRU is in use
Message-Id: <547677FB.10901@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1416982792-11917-1-git-send-email-taki@igel.co.jp> <1416982792-11917-3-git-send-email-taki@igel.co.jp> <5475CDD2.1010104@cogentembedded.com>
In-Reply-To: <5475CDD2.1010104@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Hi Sergei,

On 11/26/14, 9:55 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 11/26/2014 9:19 AM, Takanari Hayama wrote:
> 
>> Regardless of a number of inputs, we should always enable virtual RPF
>> when BRU is used. This allows the case when there's only one input to
>> BRU, and a size of the input is smaller than a size of an output of BRU.
> 
>> Signed-off-by: Takanari Hayama <taki@igel.co.jp>
>> ---
>>   drivers/media/platform/vsp1/vsp1_wpf.c | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
>> diff --git a/drivers/media/platform/vsp1/vsp1_wpf.c
>> b/drivers/media/platform/vsp1/vsp1_wpf.c
>> index 6e05776..29ea28b 100644
>> --- a/drivers/media/platform/vsp1/vsp1_wpf.c
>> +++ b/drivers/media/platform/vsp1/vsp1_wpf.c
>> @@ -92,19 +92,20 @@ static int wpf_s_stream(struct v4l2_subdev
>> *subdev, int enable)
>>           return 0;
>>       }
>>
>> -    /* Sources. If the pipeline has a single input configure it as the
>> -     * master layer. Otherwise configure all inputs as sub-layers and
>> -     * select the virtual RPF as the master layer.
>> +    /* Sources. If the pipeline has a single input and BRU is not used,
>> +     * configure it as the master layer. Otherwise configure all
>> +     * inputs as sub-layers and select the virtual RPF as the master
>> +     * layer.
>>        */
>>       for (i = 0; i < pipe->num_inputs; ++i) {
>>           struct vsp1_rwpf *input = pipe->inputs[i];
>>
>> -        srcrpf |= pipe->num_inputs = 1
>> +        srcrpf |= ((!pipe->bru) && (pipe->num_inputs = 1))
> 
>    Inner parens not needed, especially in the first case.

Ok. Will fix it.

>>               ? VI6_WPF_SRCRPF_RPF_ACT_MST(input->entity.index)
>>               : VI6_WPF_SRCRPF_RPF_ACT_SUB(input->entity.index);
>>       }
>>
>> -    if (pipe->num_inputs > 1)
>> +    if ((pipe->bru) || (pipe->num_inputs > 1))
> 
>    Likewise.

Here too. Thanks!

> [...]
> 
> WBR, Sergei

Cheers,
Takanari Hayama, Ph.D. (taki@igel.co.jp)
IGEL Co.,Ltd.
http://www.igel.co.jp/
