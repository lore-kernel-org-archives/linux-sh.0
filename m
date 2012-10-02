From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Tue, 02 Oct 2012 10:13:20 +0000
Subject: Re: [PATCH 05/14] media: add a V4L2 OF parser
Message-Id: <506ABE40.9070504@samsung.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
 <1348754853-28619-6-git-send-email-g.liakhovetski@gmx.de>
 <506A0D28.10505@gmail.com> <Pine.LNX.4.64.1210021142210.15778@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1210021142210.15778-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Guennadi,

On 10/02/2012 11:49 AM, Guennadi Liakhovetski wrote:
>>> +	if (!of_property_read_u32_array(node, "data-lanes", data_lanes,
>>> +					ARRAY_SIZE(data_lanes))) {
>>> +		int i;
>>> +		for (i = 0; i<  ARRAY_SIZE(data_lanes); i++)
>>> +			link->mipi_csi_2.data_lanes[i] = data_lanes[i];
>>
>> It doesn't look like what we aimed for. The data-lanes array is supposed
>> to be of variable length, thus I don't think it can be parsed like that. 
>> Or am I missing something ? I think we need more something like below 
>> (based on of_property_read_u32_array(), not tested):
> 
> Ok, you're right, that my version only was suitable for fixed-size arrays, 
> which wasn't our goal. But I don't think we should go down to manually 
> parsing property data. How about (tested;-))
> 
> 	data = of_find_property(node, "data-lanes", NULL);
> 	if (data) {
> 		int i = 0;
> 		const __be32 *lane = NULL;
> 		do {
> 			lane = of_prop_next_u32(data, lane, &data_lanes[i]);
> 		} while (lane && i++ < ARRAY_SIZE(data_lanes));
> 		link->mipi_csi_2.num_data_lanes = i;
> 		while (i--)
> 			link->mipi_csi_2.data_lanes[i] = data_lanes[i];
> 	}

Yes, that looks neat and does what it is supposed to do. :) Thanks!
For now, I'll trust you it works ;)

With regards to the remaining patches, it looks a bit scary to me how
complicated it got, perhaps mostly because of requirement to reference
host devices from subdevs. And it seems to rely on the existing SoC
camera infrastructure, which might imply lot's of work need to be done
for non soc-camera drivers. But I'm going to take a closer look and
comment more on the details at the corresponding patches.

--

Regards,
Sylwester
