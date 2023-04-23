#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <errno.h>
#include <string.h>

#define REG0_enable_OFFSET 0x00
#define REG1_volume_OFFSET 0x04
#define REG2_damp_OFFSET 0x08
#define REG3_minf_OFFSET 0x0C
#define REG4_maxf_OFFSET 0x10
#define REG5_delta_OFFSET 0x14
#define REG6_wetDry_OFFSET 0x18

uint32_t enable, volume, damp, minf, maxf, delta, wetDry;

void read_wah_reg(FILE *file){
	size_t ret;
	uint32_t p0_reg, p1_reg, p2_reg, p3_reg,p4_reg,p5_reg,p6_reg;
	ret = fread(&p0_reg, 4, 1, file);
	ret = fread(&p1_reg, 4, 1, file);
	ret = fread(&p2_reg, 4, 1, file);
	ret = fread(&p3_reg, 4, 1, file);
	ret = fread(&p4_reg, 4, 1, file);
	ret = fread(&p5_reg, 4, 1, file);
	ret = fread(&p6_reg, 4, 1, file);
    
	ret = fseek(file, 0, SEEK_SET);

	enable = p0_reg;
	volume = p1_reg;
	damp = p2_reg;
	minf = p3_reg;
	maxf = p4_reg;
	delta = p5_reg;
	wetDry = p6_reg;
}

void read_adc_reg(FILE *file){
	size_t ret;
	uint32_t p0_reg, p1_reg, p2_reg, p3_reg,p4_reg,p5_reg,p6_reg;
	ret = fread(&p0_reg, 4, 1, file);
	ret = fread(&p1_reg, 4, 1, file);
	ret = fread(&p2_reg, 4, 1, file);
	ret = fread(&p3_reg, 4, 1, file);
	ret = fread(&p4_reg, 4, 1, file);
	ret = fread(&p5_reg, 4, 1, file);
	ret = fread(&p6_reg, 4, 1, file);
    
	ret = fseek(file, 0, SEEK_SET);

	volume = p1_reg * 15;
	minf = (800 * p3_reg)/4095;
	maxf = p4_reg * 5;
}

void write_reg(FILE *file, uint32_t duty_0, uint32_t duty_1, uint32_t duty_2,uint32_t duty_3,uint32_t duty_4,uint32_t duty_5,uint32_t duty_6){
	size_t ret;

	ret = fseek(file, REG0_enable_OFFSET, SEEK_SET);
	ret = fwrite(&duty_0, 4, 1, file);

	ret = fseek(file, REG1_volume_OFFSET, SEEK_SET);
	ret = fwrite(&duty_1, 4, 1, file);

	ret = fseek(file, REG2_damp_OFFSET, SEEK_SET);
	ret = fwrite(&duty_2, 4, 1, file);

	ret = fseek(file, REG3_minf_OFFSET, SEEK_SET);
	ret = fwrite(&duty_3, 4, 1, file);

	ret = fseek(file, REG4_maxf_OFFSET, SEEK_SET);
	ret = fwrite(&duty_4, 4, 1, file);

	ret = fseek(file, REG5_delta_OFFSET, SEEK_SET);
	ret = fwrite(&duty_5, 4, 1, file);

	ret = fseek(file, REG6_wetDry_OFFSET, SEEK_SET);
	ret = fwrite(&duty_6, 4, 1, file);



	ret = fseek(file, 0, SEEK_SET);
}

int main () {
	FILE *adc, *wah;

	wah = fopen ("/dev/wahWahEffectProcessor" , "rb+" );
	if (wah == NULL) {
		printf("failed to open wahWahEffectProcessor file\n");
		exit(1);
	}

	adc = fopen ("/dev/adc_0" , "rb+" );
	if (adc == NULL) {
		printf("failed to open adc_0 file\n");
		exit(1);
	}
	
		read_wah_reg(wah);
		// write_reg(wah, enable, volume, damp, minf, maxf, delta, wetDry);

	while(1){
		read_adc_reg(adc);
		write_reg(wah, enable, volume, damp, minf, maxf, delta, wetDry);
	}

	fclose(adc);
	fclose(wah);

	return 0;
}
